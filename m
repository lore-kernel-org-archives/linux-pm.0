From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] RE: [PATCH 5/7] xen/acpi: Domain0 acpi
 parser related platform hypercall
Date: Wed, 7 Sep 2011 15:06:59 -0400
Message-ID: <20110907190659.GH7074__2317.84083084694$1315422749$gmane$org@dumpdata.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
	<1314815484-4668-6-git-send-email-konrad.wilk@oracle.com>
	<9F57BF860713DF4BA3EFA4F8C6DFEDAC16F3F665@ORSMSX101.amr.corp.intel.com>
	<4E67A9E7.2020802@goop.org>
	<9F57BF860713DF4BA3EFA4F8C6DFEDAC16F40F0B@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9F57BF860713DF4BA3EFA4F8C6DFEDAC16F40F0B@ORSMSX101.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Cihula, Joseph" <joseph.cihula@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "keir@xen.org" <keir@xen.org>, "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, "liang.tang@oracle.com" <liang.tang@oracle.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> > >> +#define XENPF_enter_acpi_sleep    51
> > >> +struct xenpf_enter_acpi_sleep {
> > >> +	/* IN variables */
> > >> +	uint16_t pm1a_cnt_val;      /* PM1a control value. */
> > >> +	uint16_t pm1b_cnt_val;      /* PM1b control value. */
> > > These are uint32_t in native Linux--why truncate in the API and not at use?
> > 
> > Does ACPI define them as 32 or 16 bit?
> 
> The spec indicates that the length is variable and could be up to 32 bits (AFAICT).  And Linux uses 32b, which your other patch is truncating for this call.

Yikes! Well, looks like we need to fix the Xen ABI too. Lets get that fixed
and also address all the other comments (thanks for looking at it) you pointed
out.
