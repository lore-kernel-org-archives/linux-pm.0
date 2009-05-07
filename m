From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 3/9] PM: suspend_block: Abort task freezing
	if a suspend_blocker is active.
Date: Wed, 6 May 2009 18:51:11 -0700
Message-ID: <d6200be20905061851y12b07d59t11b43d74a07aad3b@mail.gmail.com>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<1241583529-5092-4-git-send-email-arve@android.com>
	<20090505195753.GE1379@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090505195753.GE1379@ucw.cz>
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

On Tue, May 5, 2009 at 12:57 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> If a suspend_blocker is active, suspend will fail anyway. Since
>> try_to_freeze_tasks can take up to 20 seconds to complete or fail, abort=
ing
>
> Please fix try_to_freeze not to take significant time rather than
> this...

I though we covered this already. Most of the 20 second delays we saw
on earlier kernel version have been fixed, but this code can run for
20 seconds which is an unacceptable wakeup delay. Any uninterruptible
sleep in the kernel can delay the task freezing and there is no point
in completing this when we know suspend will fail.

-- =

Arve Hj=F8nnev=E5g
