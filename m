From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 0/9] Suspend block api (version 3)
Date: Wed, 06 May 2009 10:17:21 -0700
Message-ID: <873abixiam.fsf@deeprootsystems.com>
References: <1241583529-5092-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241583529-5092-1-git-send-email-arve@android.com> ("Arve
	=?iso-8859-1?Q?Hj=F8nnev=E5g=22's?= message of "Tue\,  5 May 2009
	21\:18\:40 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

Arve Hj=F8nnev=E5g <arve@android.com> writes:

> This patch series adds a suspend-block api that provides the same
> functionality as the android wakelock api. This patch series removes
> the sysdev that was used to abort suspend and adds a direct check in
> suspend_enter instead. It also has some other code style changes.

Sorry for joining the wakelock/suspend-block discussion a bit late,
but I have a very basic, and possibly stupid question on the need for
such a feature.

My basic question: is why not use idle (dynamic PM) instead of suspend
(static PM) for this?  =


IOW, why not use CPUidle + PM QoS to achieve the same goal?  It seems
to me that you're trying to add some dynamic PM features onto a static
PM subsystem.  I could see PM QoS possibly needing some extending but
the basic abilities to constrain the low-power states are there.

The one reason I can think of is that you can always have broken
drivers or apps that prevent you from hitting idle.  But with tools
like powertop, it's pretty easy to find these problems and fix them.

If that is the primary concern, it seems to me that we're introducing
a new kernel API to work around broken drivers and apps that should be
fixed instead.

What am I missing?

Kevin
