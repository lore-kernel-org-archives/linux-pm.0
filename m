From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 09:55:37 +0800
Message-ID: <1205286937.29875.9.camel__28442.5986269072$1205287009$gmane$org@caritas-dev.intel.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com> <20080311232415.GA26320@elf.ucw.cz>
	<200803120049.06491.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803120049.06491.rjw@sisk.pl>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2008-03-12 at 00:49 +0100, Rafael J. Wysocki wrote:
> On Wednesday, 12 of March 2008, Pavel Machek wrote:
[...]
> > 
> > Its certainly "more traditional" method of doing hibernation than
> > tricks swsusp currently plays.
> 
> What exactly are you referring to?

Long long ago, the hibernation is not done by Linux kernel itself but
BIOS (APM). Those days, kernel just does some preparation and jump to
BIOS to do the hibernation. Imagine kernel B is the hibernation BIOS,
kernel A does some prepare and jump to the BIOS (kernel B) just like the
old days.

> > Yes, I'd like these patches to go in, being able to switch kernels seems like
> > useful tool. 
> 
> No objection from me.
>  
> > Now, I guess they are some difficulties, like ACPI integration, and
> > some basic drawbacks, like few seconds needed to boot second kernel
> > during suspend.
> > 
> > ...OTOH this is probably only chance to eliminate freezer from
> > swsusp...
> 
> Some facts:
> 
> * In order to be able to do suspend (STR) without the freezer, we need to make
>   device drivers block access to devices from applications during suspend.
> * There's no reason to think that we can't use this same mechanism for
>   hibernation (the only difficulty seems to be the handling of devices used for
>   saving the image).

I think "kexec based hibernation" is the only currently available
possible method to write out image without freezer (after driver works
are done). If other process is running, how to prevent them from writing
to disk without freezing them in current implementation?

> * We need the drivers to quiesce devices to be able to do the kexec jump in the
>   first place (and to avoid races, we'll need them to block applications'
>   access to devices just like for STR, which is the sufficient condition for
>   removing the freezer).
> 
> So, I don't really think that the "freezer removal" argument is valid here.
> 
> Moreover, if this had been the _only_ argument for the $subject functionality,
> I'd have been against it.

Best Regards,
Huang Ying
