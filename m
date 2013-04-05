From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to
 drivers/cpufreq
Date: Fri, 05 Apr 2013 13:36:29 +0200
Message-ID: <1769336.FkfMpuXqqb@vostro.rjw.lan>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <2a5901ce31c9$95160980$bf421c80$%kim@samsung.com>
 <CAKohpokk1Q+0gRpeW=ts0a8D+rGAUpHu62X+7ejdpfom_B6FYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKohpokk1Q+0gRpeW=ts0a8D+rGAUpHu62X+7ejdpfom_B6FYA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robin.randhawa@arm.com, Ben Dooks <ben-linux@fluff.org>, linux-pm@vger.kernel.org, patches@linaro.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, Steve.Bannister@arm.com, arvind.chauhan@arm.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On Friday, April 05, 2013 12:36:34 PM Viresh Kumar wrote:
> On 5 April 2013 12:18, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Basically, this moving looks good to me, but should be re-worked based on
> > for-next of samsung tree because this touches too many samsung stuff so this
> > should be sent to upstream via samsung tree.
> 
> Hmm... Its already applied in Rafael's tree. But it doesn't mean that
> it can't be
> moved to your tree if there is a issue.

Well, I'm dropping it.  Please merge via the Samsung tree.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
