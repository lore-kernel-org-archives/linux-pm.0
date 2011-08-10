From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH 1/2] cpumask: introduce cpumask for
	hotpluggable CPUs
Date: Tue, 9 Aug 2011 19:03:42 -0700
Message-ID: <CAJOA=zPb4Nt_vJ+oTkTpj7T2kuQPV+_wUdBhsE1tty+goW50jQ__6134.41117243401$1312941902$gmane$org@mail.gmail.com>
References: <1312940007-26069-1-git-send-email-mturquette@ti.com>
	<1312940007-26069-2-git-send-email-mturquette@ti.com>
	<20110810020157.GA29494@anthem.async.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110810020157.GA29494@anthem.async.com.br>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Christian Robottom Reis <kiko@linaro.org>
Cc: linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 9, 2011 at 7:01 PM, Christian Robottom Reis <kiko@linaro.org> w=
rote:
> On Tue, Aug 09, 2011 at 06:33:26PM -0700, Mike Turquette wrote:
>> - * =A0 =A0 cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
>> - * =A0 =A0 cpu_present_mask - has bit 'cpu' set iff cpu is populated
>> - * =A0 =A0 cpu_online_mask =A0- has bit 'cpu' set iff cpu available to =
scheduler
>> - * =A0 =A0 cpu_active_mask =A0- has bit 'cpu' set iff cpu available to =
migration
>> + * =A0 =A0 cpu_possible_mask =A0 =A0 - has bit 'cpu' set iff cpu is pop=
ulatable
>> + * =A0 =A0 cpu_hotpluggable_mask - has bit 'cpu' set iff cpu is hotplug=
gable
>> + * =A0 =A0 cpu_present_mask =A0 =A0 =A0- has bit 'cpu' set iff cpu is p=
opulated
>> + * =A0 =A0 cpu_online_mask =A0 =A0 =A0 - has bit 'cpu' set iff cpu avai=
lable to scheduler
>> + * =A0 =A0 cpu_active_mask =A0 =A0 =A0 - has bit 'cpu' set iff cpu avai=
lable to migration
>
> Why not fix the 'iff' typo while you're here?

iff =3D if and only if

http://en.wikipedia.org/wiki/If_and_only_if

Thanks!
Mike

> Christian Robottom Reis, Engineering VP
> Brazil (GMT-3) | [+55] 16 9112 6430 | [+1] 612 216 4935
> Linaro.org: Open Source Software for ARM SoCs
>
