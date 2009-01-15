From: "=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=" <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Wed, 14 Jan 2009 16:10:16 -0800
Message-ID: <d6200be20901141610g51f22c5fq8c5332ab55208302@mail.gmail.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231923681.7229.244.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1231923681.7229.244.camel@nigel-laptop>
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

On Wed, Jan 14, 2009 at 1:01 AM, Nigel Cunningham
<ncunningham@crca.org.au> wrote:
> Would you be able to provide some more documentation? In particular, I'm
> wondering what's 'early' about earlysuspend. It might also be good to
> something to Documentation/power explaining what the apis are, when/how
> they're supposed to be used and such like.

I called it earlysuspend since it a prerequisite for entering the
normal suspend state. It is really the user visible suspend state.

> In the Kconfig files, I'm also missing the point to HAS_EARLYSUSPEND and
> HAS_WAKELOCK - they're bools that depends only on  and WAKELOCK
> respectively, so shouldn't you be able to just use the later symbols in
> ifdefs?

I initially had provided the wakelock and earlysuspend apis on top of
the android_power driver then added the current implementation. If
there is no interest in allowing multiple implementations of the api,
can can remove these.

> There are a few inlined #ifdefs (#ifdef CONFIG_WAKELOCK_STAT, eg) - the
> convention as I understand it is to keep #ifdefs out of .c files as much
> as possible, #ifdef'ing functions in header files instead.

I would not want to move these to the (existing) header file as they
are private to the wakelock implementation, but I could add some some
helper functions in a single #ifdef block.

-- =

Arve Hj=F8nnev=E5g
