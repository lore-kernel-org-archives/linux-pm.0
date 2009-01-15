From: "=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=" <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Thu, 15 Jan 2009 12:34:01 -0800
Message-ID: <d6200be20901151234g5322a65bv5e27d3409a7ef87d@mail.gmail.com>
References: <d6200be20901142042n5aa6384al936e49f5bce8256e@mail.gmail.com>
	<Pine.LNX.4.44L0.0901151005240.2490-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901151005240.2490-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 15, 2009 at 7:08 AM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> What do you mean by "prevents a full system suspend"?  Does it mean
> that attempts to suspend the system will fail?  Or will they just
> block until all these locks are released?

When you release the last wakelock, the wakelock code will attempt to
suspend. Holding a wakelock prevents this, and it also will abort
suspend for you if the system is in the middle of suspending drivers.

> Is there in fact any reason to add a new way for drivers to prevent a
> full system suspend?  They can already cause a suspend to fail by
> returning an error from their suspend method, or cause a suspend to
> block by sleeping in their suspend method.

Returning an error would from suspend works to some degree, but it
provides no indication of when to retry the suspend operation. Also
each suspend attempt will freeze and thaw every process in the system
so it is not a good way to ensure that userspace code gets to run.
Sleeping in the suspend method will also prevent a wakeup so it is
only usable for short delays. Wakelocks can be held for hours if
needed.

-- =

Arve Hj=F8nnev=E5g
