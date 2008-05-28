From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 28 May 2008 09:35:52 +0800
Message-ID: <1211938552.12819.122.camel__19596.8365449973$1211938713$gmane$org@caritas-dev.intel.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210830110.23707.141.camel@caritas-dev.intel.com>
	<20080516005121.GA6926@redhat.com>
	<1211873263.12819.103.camel@caritas-dev.intel.com>
	<20080527221514.GA20037@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080527221514.GA20037@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2008-05-27 at 18:15 -0400, Vivek Goyal wrote:
[...]
> > But, because IOAPIC may need to be in original state during
> > suspend/resume, so it is not appropriate to call disable_IO_APIC() in
> > ioapic_suspend(). So I think we can call disable_IO_APIC() in new
> > hibernation/restore callback.
> 
> My hunch is suspend/resume will still work if we put this call in
> ioapic_suspend() but I would not recommend that. suspend/resume does
> not need to put IOAPIC in legacy mode.
>   
> I am not sure what is "new hibernation/restore callback"? Are you
> referring to new patches from Rafel?

Yes. Rafel has a new patch to separate suspend and hibernation device
call backs.
http://kerneltrap.org/Linux/Separating_Suspend_and_Hibernation

> I think this issue is specifc to kexec and kjump so probably we should
> not tweaking any suspend/resume related bit.
> 
> How about calling disable_IO_APIC() in kexec_jump()? We can probably even
> optimize it by calling it only when we are transitioning into new image
> for the first time and not for subsquent transitions (by keeping some kind of
> count in kimage). This is little hackish but, should work...

Yes. This issue is kexec/kjump specific. We can call it in kexec_jump().
Maybe we also need call something other in native_machine_shutdown()?

BTW: I have a new version -v10: http://lkml.org/lkml/2008/5/22/106, do
you have time to review it?

Best Regards,
Huang Ying
