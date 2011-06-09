From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH v4] ARM hibernation/suspend-to-disk
 support
Date: Thu, 9 Jun 2011 16:30:08 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1106091604180.11513__44044.9611320675$1307633537$gmane$org@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106072348.44624.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: frank.hofmann@tomtom.com, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 7 Jun 2011, Rafael J. Wysocki wrote:

> On Tuesday, June 07, 2011, Frank Hofmann wrote:
[ ... ]
>> * there's kind of a circular dependency between CONFIG_HIBERNATION and
>>    CONFIG_PM_SLEEP, on ARM. The latter is necessary so that cpu_suspend
>>    and cpu_resume are compiled in, but it cannot be selected via
>>    ARCH_HIBERNATION_POSSIBLE because CONFIG_PM_SLEEP depends on
>>    CONFIG_HIBERNATION_INTERFACE - selected by CONFIG_HIBERNATION.
>>
>>    Consequence is that right now, both CONFIG_PM_SLEEP and ...HIBERNATION
>>    must be set in your defconfig file to be able to compile.
>
> In fact, CONFIG_PM_SLEEP = CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS, so it
> should be sufficient to set HIBERNATION.  ARCH_HIBERNATION_POSSIBLE only
> causes HIBERNATION to become a valid option (that may or may not be set).
>
>>    (my head swirls from writing this ...)
>
> What problem exactly did you have with those settings?

Ah, I tried to do a "select PM_SLEEP" from ARM's ARCH_HIBERNATION_POSSIBLE 
... which is circular.

Sorry the noise. It does look like the diff I sent can correctly be 
enabled just by selecting CONFIG_HIBERNATION as it's supposed to be, and 
CONFIG_PM_SLEEP will be automatically enabled then.

Found a few more nits with the patch as last sent:

- MULTI_CPU configs don't compile, needs changes (Will Deacon is on that)
   for cpu_reset.

- the hardcoded v:p offset in swsusp.S needs to go, the value can now
   be changed at kernel init and hence a small func to query it is needed

- the patch assumes the codepath is single-cpu (which the framework does
   ensure, as disable_nonboot_cpus is called) but also assumes that the
   boot CPU has ID 0; only for that is the sleep_save_sp[] entry restored.

   At least a WARN_ON(smp_processor_id()) is warranted; having a different
   core suspend the system than resume it, I'm not sure ...

- the identity mappings should match what setup_mm_for_reboot does, i.e.
   let them cover the whole user range (not just _stext.._etext). That also
   makes sure whatever happens during restore, swapper_pg_dir is "virgin"
   again afterwards.


Btw, when testing this I found that generic cpu_suspend seems to be just 
fine for OMAP3; the OMAP platforms though do not at this time use the 
generic cpu_suspend/resume for sleep, is it planned to change that ?

FrankH.



FrankH.


>
> Rafael
>
