From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] cpufreq: fix governor start/stop race condition
Date: Thu, 13 Jun 2013 14:10:17 +0530
Message-ID: <CAKohpomkKsF=-jwGw0nroi9fPAT_MWGUNnrzVobAnvn_iHAwWw@mail.gmail.com>
References: <1371028189-15758-1-git-send-email-chenxg@marvell.com>
	<CAKohponeWuaXPah4s9GjO-fLwQNuyKidUFosN1iE+e7bngDPdQ@mail.gmail.com>
	<CAFgnuDeeU5qALyqN4Akpi5SoHRXPWaq_PLYSSmjxkq9V5N=qag@mail.gmail.com>
	<CAKohpom0-Z+s4G+OOhVZJn=HK7NVKHCXS-_0FJd07K+L5DwgHA@mail.gmail.com>
	<CAFgnuDdSKDS_P2qRvCZmQzhxketojm0tQb6COuk2gnuQfs-Ztw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAFgnuDdSKDS_P2qRvCZmQzhxketojm0tQb6COuk2gnuQfs-Ztw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com
List-Id: linux-pm@vger.kernel.org

On 13 June 2013 12:49, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:

> So you add the return value checking, I was about to do it in another patch :)

What? I couldn't related that statement to my code.

> this patch is simpler than my previous patch,  it is ok for me.
> Do I need to submit it again or it can be merged?

Yeah.. Send this patch as another version so that Rafael can easily pick it
up.
