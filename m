From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 3/3] cpufreq: add suspend/resume support in Armada
 37xx DVFS driver
Date: Thu, 3 May 2018 10:06:57 +0530
Message-ID: <20180503043657.4ufzqcxuqogx34mk@vireshk-i7>
References: <e98965068836e673ea826e8a03fd01e168fce3ed.1524561482.git.viresh.kumar@linaro.org>
 <cover.1524737432.git.viresh.kumar@linaro.org>
 <d6be605205f6af01968a99582b05026aec2eca42.1524737432.git.viresh.kumar@linaro.org>
 <87r2mu8382.fsf@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87r2mu8382.fsf@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 02-05-18, 17:52, Gregory CLEMENT wrote:
> Hi Viresh,
>  
>  On jeu., avril 26 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Add suspend/resume hooks in Armada 37xx DVFS driver to handle S2RAM
> > operations. As there is currently no 'driver' structure, create one
> > to store both the regmap and the register values during suspend
> > operation.
> 
> I tested this patch on a Armada 3720 based board (EspressoBin), and it
> worked well. I even made some power consumption measurement and after
> the resume, the power consumption had the same value that before the
> suspend, for low CPU frequency and high CPU frequency.
> 
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks Gregory.

-- 
viresh
