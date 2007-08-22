From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Date: Wed, 22 Aug 2007 14:51:11 +0800
Message-ID: <1187765471.20920.62.camel__5422.71933886713$1187765521$gmane$org@caritas-dev.intel.com>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
	<20070731095101.GA1774@elf.ucw.cz>
	<1185954978.1363.23.camel@caritas-dev.intel.com>
	<20070816102635.GA2039@elf.ucw.cz>
	<1187331349.28497.9.camel@caritas-dev.intel.com>
	<20070821101404.GA1704@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070821101404.GA1704@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-08-21 at 12:14 +0200, Pavel Machek wrote:
> Ok, I got it to work -- thanks a lot.
> 
> Yes, acpi=off is mandatory. Unfortunately, thinkpad x60 does not boot
> with acpi=off (should we add another test to linux firmware kit?
> Machines should still boot in acpi=off mode...). acpi=off noapic
> nolapic nosmp makes it boot, and that in turn makes kjump work.
> 
> Screen is not refreshed on kjump back to original kernel, but I guess
> that's to be expected. I did not play with framebuffer, yet.
> 
> Maybe it is time to move kjump functionality into -mm and
> kexec-testing?

Now I have worked out a full kexec based hibernation prototype,
including kexec, write out the image, reboot, restore the memory and
jump back. I will release it recently. :)

Best Regards,
Huang Ying
