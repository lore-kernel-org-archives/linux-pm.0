From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] cpufreq/armada-37xx: Parent clock issues after boot
Date: Fri, 22 Feb 2019 09:02:01 +0530
Message-ID: <20190222033201.qdod733xtnwptxev@vireshk-i7>
References: <20190124103052.dvkg43uwieejoupo@vireshk-i7>
 <87imychbci.fsf@FE-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87imychbci.fsf@FE-laptop>
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, rjw@rjwysocki.net, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 25-01-19, 18:54, Gregory CLEMENT wrote:
> Well the idea was to modify the DVFS register before we enable
> DVFS. Indeed modifying the parent clock of a CPU while we use it could
> be a little tricky.
> 
> I have some ideas to fix this issue: I won't use anymore
> get_parent/set_parent in the cpufreq driver and I will set the DVFS
> parent clock during the initialization at the clock driver level. I need
> to do some tests to be sure of the implementation and once it was done I
> will CC you with the patch for the fix.

Hi Gregory,

I was wondering if you had any updates on this as it has been almost a
month since you shared an update.

-- 
viresh
