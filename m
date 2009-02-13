From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 09/10] Input: Hold wake lock while event
	queue is not empty.
Date: Fri, 13 Feb 2009 15:51:40 -0800
Message-ID: <d6200be20902131551v434fb375g733933c971dbecd9@mail.gmail.com>
References: <1234316955-31304-7-git-send-email-arve@android.com>
	<1234316955-31304-9-git-send-email-arve@android.com>
	<1234316955-31304-10-git-send-email-arve@android.com>
	<20090212113126.GC28176@srcf.ucam.org>
	<d6200be20902121627k7ea21f21hba24a2616e27aa42@mail.gmail.com>
	<20090213003402.GA8393@srcf.ucam.org>
	<d6200be20902121638t62687ec6k6fc39055a41a78fa@mail.gmail.com>
	<20090213004054.GB8454@srcf.ucam.org>
	<d6200be20902121652u400c450emf5e7ded1b2ea23c@mail.gmail.com>
	<20090213005704.GA8721@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213005704.GA8721@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 12, 2009 at 4:57 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrot=
e:
> On Thu, Feb 12, 2009 at 04:52:22PM -0800, Arve Hj=F8nnev=E5g wrote:
>
>> That was not the bug. Another component opened one of the input
>> devices, but did not read events from it.
>
> It's not the job of the kernel to guard against userspace doing foolish
> things.

Not true. The kernel in general tries to protect processes from
causing harm to other processes or to the kernel itself.

> Either you want to wait for input events to be consumed before
> suspend or you don't - arbitrary timeouts provide no guarantees about
> the correctness of your platform's behaviour. The default permissions on
> the event devices mean that the only components that could interfere
> with this are ones under your control, so fixing them seems like the
> sensible approach.

We did fix the bug. My point is that is it completely unreasonable for
the user space to code take more than 5 seconds to read an input
event. Trying to protecting the system (not the app) against this is
not unreasonable.

-- =

Arve Hj=F8nnev=E5g
