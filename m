From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 07/13] PM: wakelock: Add
	/sys/power/request_state
Date: Thu, 5 Feb 2009 01:25:03 -0800
Message-ID: <d6200be20902050125h7732313cj50a90c22cf35fda8@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<20090205085250.GA2077@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090205085250.GA2077@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 5, 2009 at 12:52 AM, Pavel Machek <pavel@ucw.cz> wrote:
>>  static const char * const pm_states[PM_SUSPEND_MAX] =3D {
>> +#ifdef CONFIG_WAKELOCK
>> +     [PM_SUSPEND_ON]         =3D "on",
>> +#endif
>>       [PM_SUSPEND_STANDBY]    =3D "standby",
>>       [PM_SUSPEND_MEM]        =3D "mem",
>>  };
>
> By doing this you change /sys/power/state interface. I do not think
> you want to do that.

As long as valid_state(PM_SUSPEND_ON) returns 0, /sys/power/state
should be unaffected.
However, I can hardcode the "on" state in request_state if you prefer.

-- =

Arve Hj=F8nnev=E5g
