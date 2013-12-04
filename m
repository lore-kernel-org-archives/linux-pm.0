From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [RFC v2 0/4] Add basic support for ASV
Date: Wed, 4 Dec 2013 11:30:22 +0530
Message-ID: <CAK9yfHzJL2ZKLyg7NtJisFUorTy0oVoOUwGtnWbQYGsysgG-UA@mail.gmail.com>
References: <1384515691-26299-1-git-send-email-sachin.kamat@linaro.org>
	<CAJ0PZbS8FxRA_sPTOnWbZcNfUMp=k5Jf_tZHLg1fh6gsAGJ=Gw@mail.gmail.com>
	<CAK9yfHzUAnBMB2Bp+eKzR3NH1iRguJn4K45gss5psWzG4Lc7tw@mail.gmail.com>
	<CAM4voak0QaseYoRM+rsx2Fa8qs1z=w9iVep1smxx73_SUhmkJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAM4voak0QaseYoRM+rsx2Fa8qs1z=w9iVep1smxx73_SUhmkJQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Yadwinder Singh Brar <yadi.brar01@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Bresticker <abrestic@google.com>, Doug Anderson <dianders@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Abhilash,

On 3 December 2013 20:16, Abhilash Kesavan <kesavan.abhilash@gmail.com> wrote:
> Hi Yadwinder and Sachin,

> CC'ing Doug and Andrew who have also worked on ASV.
>
> I tested these patches on a 5250 Chromebook after modifying the
> cpufreq code and a few other changes for booting the board. The driver
> is retrieving the ASV fused group correctly. The behavior on an
> unfused SMDK5250 is also fine.
> I have a few minor comments on the patches.
>

Thank you for testing and reviewing the patchset.
Will incorporate your comments in the next version.

-- 
With warm regards,
Sachin
