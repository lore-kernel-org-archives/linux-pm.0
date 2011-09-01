From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v9 2/4] PM: Introduce devfreq: generic DVFS
 framework with device-specific OPPs
Date: Thu, 1 Sep 2011 09:57:08 -0700
Message-ID: <CAJOA=zMnkNmDrCpO4Y+1TJOAPUcNwsJn0Cp+zY_NNYeFxGdzkw@mail.gmail.com>
References: <1314775779-21399-1-git-send-email-myungjoo.ham@samsung.com>
	<1314775779-21399-3-git-send-email-myungjoo.ham@samsung.com>
	<CAJOA=zM+MOAd9cCo04EzsegvkbOHRykZpiyappPptpC95b18=w@mail.gmail.com>
	<CAJ0PZbQiv0eKcTu4gzdtvXGAm9MbETeHQ7AgOcXA4gYCF8H9-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbQiv0eKcTu4gzdtvXGAm9MbETeHQ7AgOcXA4gYCF8H9-g@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: myungjoo.ham@gmail.com
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 31, 2011 at 9:51 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wr=
ote:
> On Thu, Sep 1, 2011 at 5:05 AM, Turquette, Mike <mturquette@ti.com> wrote:
>> On Wed, Aug 31, 2011 at 12:29 AM, MyungJoo Ham <myungjoo.ham@samsung.com=
> wrote:
[snip]
>>> +static void devfreq_monitor(struct work_struct *work)
>>> +{
>>> + =A0 =A0 =A0 static unsigned long last_polled_at;
>>> + =A0 =A0 =A0 struct devfreq *devfreq, *tmp;
>>> + =A0 =A0 =A0 int error;
>>> + =A0 =A0 =A0 unsigned long jiffies_passed;
>>> + =A0 =A0 =A0 unsigned long next_jiffies =3D ULONG_MAX, now =3D jiffies;
>>> +
>>> + =A0 =A0 =A0 /* Initially last_polled_at =3D 0, polling every device a=
t bootup */
>>> + =A0 =A0 =A0 jiffies_passed =3D now - last_polled_at;
>>> + =A0 =A0 =A0 last_polled_at =3D now;
>>> + =A0 =A0 =A0 if (jiffies_passed =3D=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 jiffies_passed =3D 1;
>>> +
>>> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
>>
>> Should not lock the list here. =A0If we lock the list for all major
>> operations, it nullifies the performance benefit of having a mutex in
>> struct devfreq.
>>
>
> Ok... then.. how about locking like this? :
>
> mutex_lock(&devfreq_list_lock);
> =A0=A0 =A0 =A0 list_for_each_entry_safe(devfreq, tmp, &devfreq_list, node=
) {
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&devfreq->lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 blahblah
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&devfreq->lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> =A0 =A0 =A0}
> mutex_unlock(&devfreq_list_lock);

I took a step back from the code to rethink the big picture, and I've
come back to the same conclusion conclusion that I had in the V5
patchset. (https://patchwork.kernel.org/patch/1043442/)

Firstly, there is no reason to walk the list here.  All of the locking
discussion here could just go away if we didn't walk the list of
devfreq devices every time the delay_work gets fired.  If each device
programmed it's own delayed work then this problem simply goes away.

If you don't mind I'd like to post an RFC of devfreq with these
changes implemented so we can review them and discuss the ideas around
some concrete code.

Best regards,
Mike
