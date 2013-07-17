From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 6/7] cpufreq:boost:Kconfig: Enable software managed
 BOOST support at Kconfig
Date: Wed, 17 Jul 2013 11:11:41 +0200
Message-ID: <20130717111141.7b86a304@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-7-git-send-email-l.majewski@samsung.com>
 <CAKohpokR=jrcLQQ7VAD+vr7GWgSFBfuqbOhWHwA3FCgk__EJ3Q@mail.gmail.com>
 <20130716135022.64a102f8@amdc308.digital.local>
 <CAKohpo=XbUtYBVQ_y4_R18wpag_HAVvXrxfSfmaNSqq=wLpciQ@mail.gmail.com>
 <20130717091706.69b77c2f@amdc308.digital.local>
 <CAKohpona8E-JgLxyLnc_QuS9LAuJ7FBbsSGPZawQtOd8kRd4JA@mail.gmail.com>
 <20130717101251.164fbad8@amdc308.digital.local>
 <CAKohponWhYFntyay004qErHxFRkjZEtes-+ZHE49oG-CrZMzOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKohponWhYFntyay004qErHxFRkjZEtes-+ZHE49oG-CrZMzOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, "l.majewski@majess.pl" <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Jul 2013 10:29:15 +0200 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 17 July 2013 13:42, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > Then it should be enough to only write:
> >
> > depends on THERMAL
> >
> > (since CPUFREQ is already enabled for entering this menu).
> 
> Correct

OK.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
