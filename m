From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Tue, 10 Feb 2009 18:11:59 -0800
Message-ID: <d6200be20902101811n69c89489u1984d6554152661@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205225158.GA19577@linux.intel.com>
	<d6200be20902051613k77ef5878v7734653749ead8a@mail.gmail.com>
	<20090210202507.GE1382@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090210202507.GE1382@ucw.cz>
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
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 10, 2009 at 12:25 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Wakelock is really bad name: it is not a lock and it does not protect
> wake. I'd say we need better name here.

It is similar to a reader/writer lock, and it does protect the wake
state. The writer, the suspend code, blocks until all the readers
release their lock. If there are no readers after suspending all the
drivers, the wake state changes. Since the readers can only run when
in the awake state, they never block.

-- =

Arve Hj=F8nnev=E5g
