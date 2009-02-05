From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: Acer 6592 TM, suspend to ram and resume freeze
Date: Thu, 05 Feb 2009 20:08:58 +0100
Message-ID: <8763jo1z1x.fsf__36439.5518591211$1233861200$gmane$org@free.fr>
References: <873aevl0l8.fsf@free.fr> <1233712347.6643.7.camel@rzhang-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233712347.6643.7.camel@rzhang-desktop> (ZhangRui's message of
	"Wed\, 04 Feb 2009 09\:52\:27 +0800")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ZhangRui <rui.zhang@intel.com>, yakui_zhao <yakui.zhao@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

ZhangRui <rui.zhang@intel.com> writes:
> what if you build in the ACPI processor driver (CONFIG_ACPI_PROCESSOR=y)
> and boot with "processor.max_cstate=1"?
That doesn't help, thanks for the hint.

>> Now, I notice that loading acpi-cpufreq triggers the following message :
>> > log: Jan 19 18:23:42 velvet kernel: ACPI: EC: non-query interrupt received, switching to interrupt mode
>> 
> I don't think these two are related. can you please make a double check?
You're right. Loading thermal.ko leads to the same message, yet the suspend to
ram works.

yakui_zhao <yakui.zhao@intel.com> writes:
> Will you please try the latest kernel(2.6.29-rc3)?
>      If the problem still exists, please attach the output of dmesg,
> acpidump.
Yes, great, it works in 2.6.29-rc3!!! It's amazing, because, when I check acpi
in [1], I see no change which could have led to the fix.
I provided acpidump in [2] as information.

Well, I' consider the topic solved. I'll make further tests this weekend to test
all of my laptop functions, but my hopes are quite high.

Thanks a lot, the three of you.

--
Robert

[1] : Git ACPI check
velvet:~/kernel_src/linux-2.6# git-log --pretty=oneline v2.6.29-rc3 ^v2.6.29-rc1 drivers/acpi/
88d998c264722cd6e8fafa42aee191f7d9194960 Merge branch 'misc' into release
f1f055f1036a20742608c28ee82139f572dfd031 Merge branches 'bugzilla-11884' and 'bugzilla-8544' into release
d08ca2ca743f324eceba59e93188f9439e966bce ACPI: rename main.c to sleep.c
0e4240d94628530a912d216cad1e32d2e3827327 thermal fixup for broken BIOS which has invalid trip points.
c6cb0e878446c79f42e7833d7bb69ed6bfbb381f ACPI: EC: Don't trust ECDT tables from ASUS
235c4a59278eb07e61d909f1f0c233733034a8b3 ACPI: EC: Limit workaround for ASUS notebooks even more

[2] http://belgarath.hd.free.fr/download/acer6592tm/acpidump.txt.gz
