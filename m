From: "=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=" <arve@android.com>
Subject: Re: [PATCH 04/11] PM: Implement early suspend api
Date: Wed, 14 Jan 2009 15:57:10 -0800
Message-ID: <d6200be20901141557g55e63459wb7d38d07b223c53a@mail.gmail.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-2-git-send-email-arve@android.com>
	<1231896476-22445-3-git-send-email-arve@android.com>
	<1231896476-22445-4-git-send-email-arve@android.com>
	<1231896476-22445-5-git-send-email-arve@android.com>
	<1231926517.7229.332.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1231926517.7229.332.camel@nigel-laptop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 14, 2009 at 1:48 AM, Nigel Cunningham
<ncunningham@crca.org.au> wrote:
>> +enum {
>> +     DEBUG_USER_STATE =3D 1U << 0,
>> +     DEBUG_SUSPEND =3D 1U << 2,
>> +};
>
> Is there a reason DEBUG_SUSPEND isn't 1U << 1? If so, it might be good
> to document that here.
>

No. I missed it when separating the wake lock and early suspend code.

>> +     if (debug_mask & DEBUG_SUSPEND)
>> +             pr_info("early_suspend: sync\n");
>> +
>> +     sys_sync();
>
> Why the sync here?

At this point the device appears to asleep to the user but wakelocks
can prevent full suspend (which also calls sys_sync).

>> +     if (state =3D=3D SUSPENDED)
>> +             state &=3D ~SUSPENDED;
>
> Why not just say state =3D 0?
>
Only the SUSPENDED bit may be modified here, but in this case state =3D 0 i=
s safe.


-- =

Arve Hj=F8nnev=E5g
