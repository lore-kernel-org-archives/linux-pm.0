From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: linux-next: Tree for Apr 9 [cpufreq: NULL pointer deref]
Date: Tue, 9 Apr 2013 22:21:09 +0530
Message-ID: <CAKohponzmLzPN8ua3p4TCt2waZCQCd+4Znh+tSQ4MBjcy+Ss6A@mail.gmail.com>
References: <CA+icZUU_K9PiFMqMsOEk1+c2DX8LrUojZptPiRVarv4dcB2qFA@mail.gmail.com>
	<31778276.CDMUtaAAnc@vostro.rjw.lan>
	<CA+icZUXXHb9vmcNuFmYha34SV7xch2S8OcgZ+cLVVnNebs5pNQ@mail.gmail.com>
	<CAKohpok+9dRaENjBfnN9gZF3zvFU9v19xV_eFfcM3Pj6Cv=S2w@mail.gmail.com>
	<CA+icZUWH5Ni9koj4V8Ws8jJ7smwmU7JuUWBFh=aiCqkrCpqB5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CA+icZUWH5Ni9koj4V8Ws8jJ7smwmU7JuUWBFh=aiCqkrCpqB5A@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 9 April 2013 21:38, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> With x=3 the system gets in an unuseable state.
>
>      root# echo 0 > /sys/devices/system/cpu/cpu3/online
>
> I could not write my reply and had to do a hard/cold reboot.
> The dmesg log I saw looked similiar to my digicam-shot.

Few things i need from you. First is output of cpufreq-info. Then
all the steps you did to reproduce above? Removed any other cpus?

I am not able to find next-20130326 tag in my repo, only have 23 and 28.
Can you debug it a bit to find exact line of code causing this issue using
objdump?

HINT: Documentation/BUG-HUNTING..

Give me line numbers of both of these functions: __cpufreq_governor() and
__cpufreq_remove_dev().
