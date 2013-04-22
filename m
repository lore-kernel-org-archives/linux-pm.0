From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [V3 patch 17/19] ARM: kirkwood: cpuidle: use init/exit common
 routine
Date: Mon, 22 Apr 2013 18:47:56 +0200
Message-ID: <20130422164756.GG29947@lunn.ch>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-18-git-send-email-daniel.lezcano@linaro.org>
 <20130414151429.GF5061@lunn.ch> <5174E036.9090808@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5174E036.9090808@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, swarren@wwwdotorg.org, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, patches@linaro.org, rob.herring@calxeda.com, rjw@sisk.pl, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, lethal@linux-sh.org, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 22, 2013 at 09:01:10AM +0200, Daniel Lezcano wrote:
> On 04/14/2013 05:14 PM, Andrew Lunn wrote:
> 
> [ ... ]
> >  int kirkwood_cpuidle_remove(struct platform_device *pdev)
> >  {
> > -	cpuidle_unregister_device(device);
> > -	cpuidle_unregister_driver(&kirkwood_idle_driver);
> > -
> > +	cpuidle_unregister(&kirkwood_idle_driver);
> >  	return 0;
> >  }
> >  
> > -- 
> > 1.7.9.5
> >
> > Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> Hi Andrew,
> 
> shall I consider it as acked-by also ?

Yes, please do.

     Andrew
