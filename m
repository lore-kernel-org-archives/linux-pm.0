From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V4] thermal: Add cooling device's statistics in sysfs
Date: Tue, 20 Mar 2018 11:19:20 +0800
Message-ID: <1521515960.2284.1.camel@intel.com>
References: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
         <1520924571.3766.8.camel@intel.com> <1521014472.2087.32.camel@intel.com>
         <20180314081426.GG15832@vireshk-i7>
         <20180320013836.hiu6oy3smwmk35tp@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320013836.hiu6oy3smwmk35tp@vireshk-mac-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 二, 2018-03-20 at 09:38 +0800, Viresh Kumar wrote:
> On 14-03-18, 13:44, Viresh Kumar wrote:
> > 
> > I got those warnings as well, and I quietly ignored them :)
> > 
> > I ignored the renaming part for the sake of consistency. The other
> > existing
> > routines for similar purpose are named as:
> > 
> > thermal_cooling_device_type_show
> > thermal_cooling_device_max_state_show
> > thermal_cooling_device_cur_state_show
> > thermal_cooling_device_cur_state_store
> > 
> > for me it made more sense to follow that naming convention. And I
> > didn't use the
> > _RO and _WO variants for the same reason.
> > 
> > Now here is what I propose now:
> > 
> > - You apply this patch as-is and ignore the warning.
> > 
> > - I will send few patches on top of that to do:
> >   - renaming of all such routines to shorter versions.
> >   - Use the _RO or _WO variants of the macro everywhere.
> > 
> > What do you say ?
> @Zhang: Can you please share the way you want this to get merged ?
> And if the
> above is fine with you ?
> 
yes, it works for me.
I will apply the patch later today.

thanks,
rui
