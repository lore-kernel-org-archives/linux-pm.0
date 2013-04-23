From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to
 drivers/cpufreq
Date: Wed, 24 Apr 2013 00:25:59 +0900
Message-ID: <5176A807.2090005@samsung.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <2a5901ce31c9$95160980$bf421c80$%kim@samsung.com>
 <CAKohpokk1Q+0gRpeW=ts0a8D+rGAUpHu62X+7ejdpfom_B6FYA@mail.gmail.com>
 <1769336.FkfMpuXqqb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1769336.FkfMpuXqqb@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: robin.randhawa@arm.com, patches@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Steve.Bannister@arm.com, Kukjin Kim <kgene.kim@samsung.com>, arvind.chauhan@arm.com, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On 04/05/13 20:36, Rafael J. Wysocki wrote:
> On Friday, April 05, 2013 12:36:34 PM Viresh Kumar wrote:
>> On 5 April 2013 12:18, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>>> Basically, this moving looks good to me, but should be re-worked based on
>>> for-next of samsung tree because this touches too many samsung stuff so this
>>> should be sent to upstream via samsung tree.
>>
>> Hmm... Its already applied in Rafael's tree. But it doesn't mean that
>> it can't be
>> moved to your tree if there is a issue.
>
> Well, I'm dropping it.  Please merge via the Samsung tree.
>

Oops, I missed, maybe I have no more chance to send this to upstream for 
upcoming merge window :-(

Rafael, please take this patch with my ack in your tree, sorry for noise.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

If any problems, please kindly let me know.

Thanks.

- Kukjin
