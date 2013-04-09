From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: linux-next: Tree for Apr 9 [cpufreq: NULL pointer deref]
Date: Tue, 9 Apr 2013 18:08:46 +0200
Message-ID: <CA+icZUWH5Ni9koj4V8Ws8jJ7smwmU7JuUWBFh=aiCqkrCpqB5A@mail.gmail.com>
References: <CA+icZUU_K9PiFMqMsOEk1+c2DX8LrUojZptPiRVarv4dcB2qFA@mail.gmail.com>
	<31778276.CDMUtaAAnc@vostro.rjw.lan>
	<CA+icZUXXHb9vmcNuFmYha34SV7xch2S8OcgZ+cLVVnNebs5pNQ@mail.gmail.com>
	<CAKohpok+9dRaENjBfnN9gZF3zvFU9v19xV_eFfcM3Pj6Cv=S2w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpok+9dRaENjBfnN9gZF3zvFU9v19xV_eFfcM3Pj6Cv=S2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 9, 2013 at 4:56 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 9 April 2013 19:34, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> I have seen it on reboots.
>> How to online/offline from sysfs?
>
> offline a cpu "x" with:
>
> echo 0 > /sys/devices/system/cpu/cpux/online
>
> and online with echo 1 > to same location.

With x=3 the system gets in an unuseable state.

     root# echo 0 > /sys/devices/system/cpu/cpu3/online

I could not write my reply and had to do a hard/cold reboot.
The dmesg log I saw looked similiar to my digicam-shot.

- Sedat -
