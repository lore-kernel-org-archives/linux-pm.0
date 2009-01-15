From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Thu, 15 Jan 2009 10:08:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901151005240.2490-100000@iolanthe.rowland.org>
References: <d6200be20901142042n5aa6384al936e49f5bce8256e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20901142042n5aa6384al936e49f5bce8256e@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

6~On Wed, 14 Jan 2009, Arve Hj=F8nnev=E5g wrote:

> On Wed, Jan 14, 2009 at 1:01 AM, Nigel Cunningham
> <ncunningham@crca.org.au> wrote:
> > Would you be able to provide some more documentation?
> =

> Would something like this help:
> Documentation/power/wakelocks.txt
> =

> Wakelocks
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> A wake_lock prevents the system from entering suspend or other low power
> states when active. If the type is set to WAKE_LOCK_SUSPEND, the wake_lock
> prevents a full system suspend. If the type is WAKE_LOCK_IDLE, low power
> states that cause large interrupt latencies or that disable a set of
> interrupts will not entered from idle until the wake_locks are released.

Apart from the grammatical errors in this document and the
over-engineering it describes, the writeup is terribly ambiguous.  =

What do you mean by "prevents a full system suspend"?  Does it mean
that attempts to suspend the system will fail?  Or will they just
block until all these locks are released?

Is there in fact any reason to add a new way for drivers to prevent a =

full system suspend?  They can already cause a suspend to fail by =

returning an error from their suspend method, or cause a suspend to =

block by sleeping in their suspend method.

Alan Stern
