From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/8] firmware: arm_scmi: rename get_transition_latency
 and add_opps_to_device
Date: Thu, 10 May 2018 10:53:06 +0100
Message-ID: <20180510095306.GA24594@e107155-lin>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
 <1525885634-22348-4-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0ixZPB8aZs0xc9-3JMrWfRC7+7mzYWNaCj1o_q6VSqEJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ixZPB8aZs0xc9-3JMrWfRC7+7mzYWNaCj1o_q6VSqEJA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 10, 2018 at 10:29:48AM +0200, Rafael J. Wysocki wrote:
> On Wed, May 9, 2018 at 7:07 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > Most of the scmi code follows the suggestion from Greg KH on a totally
> > different thread[0] to have the subsystem name first, followed by the
> > noun and finally the verb with couple of these exceptions.
> >
> > This patch fixes them so that all the functions names are aligned to
> > on practice.
> >
> > [0] https://www.spinics.net/lists/arm-kernel/msg583673.html
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> ACK for the cpufreq driver changes and I'm assuming this to go in via the arch.
>

Thanks, yes I plan to send it via ARM-SoC.

--
Regards,
Sudeep
