From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [linux-pm] [PATCH 2/4] thermal: Add generic cpufreq cooling implementation
Date: Tue, 13 Mar 2012 12:00:28 +0200
Message-ID: <CAP245DUqz-N3nG+bc-3b=4YgYk3LMJTWk_wB7Db1ZBm0fBQOSQ@mail.gmail.com>
References: <1329905650-30161-1-git-send-email-amit.kachhap@linaro.org>
	<1329905650-30161-3-git-send-email-amit.kachhap@linaro.org>
	<CAMHCuPUOnftKYaGjEpA9rZFc1yjH3U-EkEEUWqcFapSKROTopQ@mail.gmail.com>
	<CAK44p23nZ0kgdieasMkChV8B51Rjt=KrmypN+ksV+nym_e0Cqw@mail.gmail.com>
	<CAMHCuPXSCZjiyW28aPPjO4zF0vgabZUrqtUK5nMXLwNzSWUjQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMHCuPXSCZjiyW28aPPjO4zF0vgabZUrqtUK5nMXLwNzSWUjQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sundar <sunder.svit@gmail.com>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, len.brown@intel.com, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mark.gross@intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Sundar,

On Tue, Mar 13, 2012 at 11:45 AM, Sundar <sunder.svit@gmail.com> wrote:
> Hi Amit,
>
> Thanks for the replies. One more query
>
> On Tue, Mar 13, 2012 at 10:37 AM, Amit Kachhap <amit.kachhap@linaro.org> wrote:
>
>>> "Different cpu related cooling devices": Do you mean cooling devices
>>> for different CPUs (num_cpus) or are you referring to different
>>> customers aka consumer drivers who could use this framework and impose
>>> the cooling.
>> Correct but the consumer driver only has to use the other
>> thermal-sys.c functions. Only register cpu cooling devices is
>> implemented in this work.
>
> Am i right in noting that this framework then doesnt handle other
> devices for cooling like Graphics, LCD etc?

At the moment it doesn't. But there was some discussion around
creating something that will work with devfreq. This would allow
peripheral drivers to be plugged in as well. Amit is investigating
that at present.

/Amit
