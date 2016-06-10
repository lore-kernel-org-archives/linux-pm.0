From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Fri, 10 Jun 2016 16:52:45 -0500
Message-ID: <CAPBZ5QfzDG9AQbZoZ44x0N4T4gZTdeEgvuxr1+aq-zO4ZrsMHg@mail.gmail.com>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
 <20160610154857.GA6430@leverpostej>
 <20160610161234.GO13357@hector.attlocal.net>
 <20160610162555.GB6430@leverpostej>
 <20160610164721.GP13357@hector.attlocal.net>
 <20160610211636.GA38979@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160610211636.GA38979@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 10 June 2016 at 16:16, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Fri, Jun 10 2016 at 10:47 -0600, Andy Gross wrote:
>>
>> On Fri, Jun 10, 2016 at 05:25:55PM +0100, Mark Rutland wrote:
>>>
>>> On Fri, Jun 10, 2016 at 11:12:34AM -0500, Andy Gross wrote:
>>> > On Fri, Jun 10, 2016 at 04:48:57PM +0100, Mark Rutland wrote:
>>> > > [+ Lorenzo]
>>> > >
>>> > > On Thu, May 19, 2016 at 12:00:18AM -0500, Andy Gross wrote:
>
> <...>
>>>
>>>
>>> > I chose to do this outside of the arm cpuidle driver because I didn't
>>> > want to
>>> > add any more DT information aside from the compatible, and I needed a
>>> > separate
>>> > place for the Qualcomm specific suspend code.
>>>
>>> Which suspend code is Qualcomm-specific? There shouldn't be anything on
>>> the PSCI side, so I can only imagine that device management is left.
>>> What am I missing?
>>
>>
>
>> Qualcomm won't be supporting the psci suspend feature and will be doing
>> their
>> own thing.  As such, they need their own suspend ops.  In addition, we
>> have
>> platforms that don't use psci (32 bit).
>>
> Andy, which PSCI suspend feature are you referring to, here? On 8916, we
> do support CPU_SUSPEND in PSCI.
>
> You don't want to call SYSTEM_SUSPEND, as it requires the other CPUs to
> be CPU_OFF (hotplugged off) before the last core calls this PSCI
> function.

I was referring to the SYSTEM_SUSPEND psci feature.  It was my
understanding that wouldn't be supported on the Qualcomm platforms.

Regards,

Andy
