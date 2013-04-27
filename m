From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 2/4] Thermal: exynos: Support for TMU regulator
 defined at device tree
Date: Sat, 27 Apr 2013 08:50:52 +0800
Message-ID: <1367023852.2196.2.camel@rzhang1-mobl4>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	 <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
	 <1366893045-31586-3-git-send-email-l.majewski@samsung.com>
	 <CADGdYn6g5Lggkcbq9WMMfbqN-NBb_14_b1bfcd=7+CJrxJcquA@mail.gmail.com>
	 <20130425152934.5041cc98@amdc308.digital.local> <51794F48.5040401@ti.com>
	 <20130425182941.63ecff30@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130425182941.63ecff30@amdc308.digital.local>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, amit daniel kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi, all,

what is the status now?
which one is preferred, this one or the one from Amit's patch set?

thanks,
rui


On Thu, 2013-04-25 at 18:29 +0200, Lukasz Majewski wrote:
> Hi Eduardo,
> 
> > Amit, Lukasz,
> > 
> > On 25-04-2013 09:29, Lukasz Majewski wrote:
> > > Hi Amit,
> > >  
> > >> Hi Lukasz Majewski,
> > >>
> > >> Sorry for late review but I am currently working on restructuring
> > >> the whole exynos thermal driver and this support of LDO can be
> > >> added as feature as not all socs support this. This is also
> > >> suggested by Eduardo. All your other patches looks fine.  
> > >
> > > But this is how it is already done. The VDD_TS is optional, so
> > > Exynos5440 and Exynos4210 will not be broken.
> > >
> > > This shall preserve the correct behavior of the thermal driver.
> > >  
> > 
> > If you guys plan to move to feature based approach, like suggested in 
> > V1, then Id recommend adding a /* TODO: */ entry in your driver.
> 
> Ok, nice idea.
> 
> > 
> > Amit, are you including this LDO support on your rework?
> 
> 
> 
