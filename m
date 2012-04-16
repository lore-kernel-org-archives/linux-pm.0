From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: Devfreq Simple On Demand Governor
Date: Mon, 16 Apr 2012 23:16:49 +0900
Message-ID: <CAJ0PZbQB3USyV65KNERn01yF-KFgi9o7yRJquoOc0iBWotv6PA@mail.gmail.com>
References: <CAChS5kNS6DUq9W-R0XkQ8ksojUAbsLy5opz1eKb5iaa0D895cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAChS5kNS6DUq9W-R0XkQ8ksojUAbsLy5opz1eKb5iaa0D895cw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Satendra..." <satendra.pratap@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 16, 2012 at 7:07 PM, Satendra... <satendra.pratap@gmail.com> wr=
ote:
> Hi Ham,
>
> I was looking at the simple on demand governor's code and have got few
> queries:
> - In the code below to check for overflow, why 24 and 7 =A0has been taken?
> =A0 =A0 =A0 =A0 /* Prevent overflow */
> =A0 =A0 =A0 =A0 if (stat.busy_time >=3D (1 << 24) || stat.total_time >=3D=
 (1 << 24)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat.busy_time >>=3D 7;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat.total_time >>=3D 7;
> =A0 =A0 =A0 =A0 }

It is because 1<<7 >=3D 100 and 1<<6 < 100. (To get percentage, we are
multiplying 100).

>
> - Also for maximum frequency UINT_MAX is returned which may not be suited
> for some devices.

The frequency given to devfreq driver is "recommended frequency", not
the "exact frequency required".

Thus, the driver is required to choose
1. frequency that is at least (but closest) or same with the
"recommended frequency"
and if that's impossible,
2. frequency that is closest to the "recommended frequency".

Thus, if it's "UINT_MAX", then it should choose the maximum frequency.

>
> - One more query, whats the unit (usecs, nsecs etc) used for busy and load
> time. Has it got nothing to do with units
> and its mere the percentage of busy time?

The unit is up to the device driver. It only needs to provide
"reasonable" values in u32 to the infrastructure. It could be usec,
nsec, #ops, or anything else.
I've mentioned it only because jiffy does not seem to be "reasonable";
jiffy is too rough. You may even get 0 jiffies for 100 operations
while you may get 1 jiffy for 1 operation in the same system.

In the governors, maybe busy / total ratio can be used as in
simple_ondemand. And you should give values that can support some fair
granularity there, which jiffy cannot.

>
> - If we want to use simple on demand governor then do we need to modify
> yours to suit our needs? I mean you have
> just provided a framework?

If you want to use THE simple_ondemand for your device, you only need
to create a devfreq driver. You don't need to modify the governor or
the framework/.

>
> Thanks,
> Satendra


Cheers!
MyungJoo.

-- =

MyungJoo Ham, Ph.D.
System S/W Lab, S/W Center, Samsung Electronics
