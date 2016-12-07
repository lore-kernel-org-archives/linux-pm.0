From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 8/8] cpufreq: intel_pstate: Use CPPC to get max performance
Date: Thu, 08 Dec 2016 00:29:29 +0100
Message-ID: <4248602.ecJ9y5gJMR@aspire.rjw.lan>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com> <20161207190608.boi7svavwrkx3epm@breakpoint.cc> <1481152373.3064.77.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1481152373.3064.77.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 07, 2016 03:12:53 PM Tim Chen wrote:
> On Wed, 2016-12-07 at 20:06 +0100, Sebastian Andrzej Siewior wrote:
> > 
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  drivers/acpi/cppc_acpi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index d0d0504b7c89..93252e5374c5 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -803,6 +803,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
> >  		if (addr)
> >  			iounmap(addr);
> >  	}
> > +	per_cpu(cpc_desc_ptr, pr->id) = NULL;
> >  	kfree(cpc_ptr);
> >  
> >  out_buf_free:
> > @@ -824,6 +825,8 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
> >  	void __iomem *addr;
> >  
> >  	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
> > +	if (!cpc_ptr)
> > +		return;
> 
> I agree that not handling null pointer here is a bug that should be fixed.
> The cpc_ptr is checked at other places like acpi_get_psd_map.  
> We could potentially have a null cpc_ptr say when
> the parsing of CPC table failed. We should handle such cases gracefully.

Agreed, but the bug fixed by the first hunk is real too.  I'd fix it a bit
differently, though:

Tentatively-signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
 drivers/acpi/cppc_acpi.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -776,9 +776,6 @@ int acpi_cppc_processor_probe(struct acp
 		init_waitqueue_head(&pcc_data.pcc_write_wait_q);
 	}
 
-	/* Plug PSD data into this CPUs CPC descriptor. */
-	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
-
 	/* Everything looks okay */
 	pr_debug("Parsed CPC struct for CPU: %d\n", pr->id);
 
@@ -789,10 +786,15 @@ int acpi_cppc_processor_probe(struct acp
 		goto out_free;
 	}
 
+	/* Plug PSD data into this CPUs CPC descriptor. */
+	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
+
 	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");
-	if (ret)
+	if (ret) {
+		per_cpu(cpc_desc_ptr, pr->id) = NULL;
 		goto out_free;
+	}
 
 	kfree(output.pointer);
 	return 0;
@@ -826,6 +828,8 @@ void acpi_cppc_processor_exit(struct acp
 	void __iomem *addr;
 
 	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
+	if (!cpc_ptr)
+		return;
 
 	/* Free all the mapped sys mem areas for this CPU */
 	for (i = 2; i < cpc_ptr->num_entries; i++) {

