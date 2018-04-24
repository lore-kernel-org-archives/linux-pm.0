From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/3] cpufreq: add suspend/resume support in Armada
 37xx DVFS driver
Date: Tue, 24 Apr 2018 14:49:38 +0530
Message-ID: <20180424091938.kmbhmfjnem6cneb3@vireshk-i7>
References: <cover.1524549644.git.viresh.kumar@linaro.org>
 <4ca19364ff10083c3912ce428207c3f713f973b9.1524549644.git.viresh.kumar@linaro.org>
 <20180424111046.704637d3@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180424111046.704637d3@xps13>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 24-04-18, 11:10, Miquel Raynal wrote:
> Hi Viresh,
> 
> On Tue, 24 Apr 2018 11:37:36 +0530, Viresh Kumar
> <viresh.kumar@linaro.org> wrote:
> 
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > 
> > Add suspend/resume hooks in Armada 37xx DVFS driver to handle S2RAM
> > operations. As there is currently no 'driver' structure, create one
> > to store both the regmap and the register values during suspend
> > operation.
> > 
> > A syscore_ops is used to export the suspend/resume hooks.
> 
> I think you can remove this line too since there is no more syscore_ops.

That was stupid of me.

-- 
viresh
