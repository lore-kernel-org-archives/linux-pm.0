From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 09/10] Input: Hold wake lock while event
	queue is not empty.
Date: Sat, 14 Feb 2009 00:06:17 +0100
Message-ID: <200902140006.18420.rjw@sisk.pl>
References: <1234316955-31304-7-git-send-email-arve@android.com>
	<d6200be20902121652u400c450emf5e7ded1b2ea23c@mail.gmail.com>
	<20090213005704.GA8721@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213005704.GA8721@srcf.ucam.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, Arve@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 13 February 2009, Matthew Garrett wrote:
> On Thu, Feb 12, 2009 at 04:52:22PM -0800, Arve Hj=F8nnev=E5g wrote:
> =

> > That was not the bug. Another component opened one of the input
> > devices, but did not read events from it.
> =

> It's not the job of the kernel to guard against userspace doing foolish =

> things.

Amen.

> Either you want to wait for input events to be consumed before =

> suspend or you don't - arbitrary timeouts provide no guarantees about =

> the correctness of your platform's behaviour. The default permissions on =

> the event devices mean that the only components that could interfere =

> with this are ones under your control, so fixing them seems like the =

> sensible approach.

This is exactly my point, but I couldn't find words to say it so clearly.

Thanks,
Rafael
