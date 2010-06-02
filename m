From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 20:50:02 -0700
Message-ID: <AANLkTikF-B23_UWG1O3tlBl4m8NStAJllGhhevNhYZT6__8365.48642623729$1275450686$gmane$org@mail.gmail.com>
References: <AANLkTik_4ezDAQoAQjkpEgwD9SLKeOjDzy2H7T2v6uCP@mail.gmail.com>
	<Pine.LNX.4.44L0.1005292026080.6300-100000@netrider.rowland.org>
	<AANLkTikxws5kmFhnBO1MLzE65ETka3Jy0R5ayAKTS1Lc@mail.gmail.com>
	<201005312338.55109.rjw@sisk.pl> <20100531232617.GF31155@gvim.org>
	<20100601090737.4bc243d9@schatten.dmk.lab>
	<20100601140519.GC1281@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100601140519.GC1281@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: 640e9920@gmail.com, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 1, 2010 at 7:05 AM, mark gross <640e9920@gmail.com> wrote:
> On Tue, Jun 01, 2010 at 09:07:37AM +0200, Florian Mickler wrote:
...
>> +static void update_target_val(int pm_qos_class, s32 val)
>> +{
>> + =A0 =A0 s32 extreme_value;
>> + =A0 =A0 s32 new_value;
>> + =A0 =A0 extreme_value =3D atomic_read(&pm_qos_array[pm_qos_class]->tar=
get_value);
>> + =A0 =A0 new_value =3D pm_qos_array[pm_qos_class]->comparitor(val,extre=
me_value);
>> + =A0 =A0 if (extreme_value !=3D new_value)
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&pm_qos_array[pm_qos_class]->target=
_value,new_value);
>> +}
>> +
>
> Only works 1/2 the time, but I like the idea!
> It fails to get the righ answer when constraints are reduced. =A0But, this
> idea is a good improvement i'll roll into the next pm_qos update!
>

I think it would be a better idea to track your constraints with a
sorted data structure. That way you can to better than O(n) for both
directions. If you have a lot of constraints with the same value, it
may even be worthwhile to have a two stage structure where for
instance you use a rbtree for the unique values and list for identical
constraints.

-- =

Arve Hj=F8nnev=E5g
