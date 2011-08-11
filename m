From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v2 0/2] new cpumask for hotpluggable CPUs
Date: Thu, 11 Aug 2011 12:25:53 -0700
Message-ID: <CAJOA=zNoTbPViL81esyD0So_D70_0_BAxrM2ks3SgV5=FSTWHQ__48528.0345696539$1313090910$gmane$org@mail.gmail.com>
References: <1313006614-28702-1-git-send-email-mturquette@ti.com>
	<1313087423.8491.11.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313087423.8491.11.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 11, 2011 at 11:30 AM, Peter Zijlstra <peterz@infradead.org> wro=
te:
> On Wed, 2011-08-10 at 13:03 -0700, Mike Turquette wrote:
>> This patch series introduces a new cpumask which tracks CPUs that
>> support hotplugging. =A0The purpose of this patch series is to provide a
>> simple method for kernel code to know which CPUs can be hotplugged and
>> which ones cannot. =A0Potential users of this code might be a thermal
>> mitigation technique which uses hotplug to lower temperature, or a power
>> capping mechanism which uses hotplug to lower power consumption.
>>
>> All the of usual cpumask helper functions are created for this new mask.
>> The second patch in this series simply sets the bit for elligible CPUs
>> while they are being registered. =A0The cpumask itself is static after
>> boot and should not change (like the possbile mask).
>
> I still most strongly object to people using hotplug for these goals.
>
> Why do you need to go through the entire dance of hotplug just to idle a
> cpu? Hotplug not only idles the cpu but tears down (and rebuilds) an
> insane amount of resources associated with the cpu.

I think you're nacking the wrong series.  This patchset simply allows
kernel space to know which CPUs can go offline and which one can't,
which seems pretty innocuous.  Are you fundamentally opposed to the
kernel having better accessor functions to this data?

I'll soon be posting some code which does implement hotplug as a
power-capping feature.  I think *that* is the patch that you'll want
to nack.

Thanks for reviewing,
Mike

> Nacked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
>
