From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH] apm-emulation: Fix mutex race condition
Date: Tue, 3 May 2011 20:19:57 +0100 (BST)
Message-ID: <729677.85794.qm@web29008.mail.ird.yahoo.com>
References: <201105032023.51728.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105032023.51728.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

--- On Tue, 3/5/11, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hmm.=A0 I'd rather use mutex_trylock() and call try_to_freeze() if
> that fails.
> =

> Is there anything wrong with this approach?

Well, mutex_trylock() doesn't wait if it cannot acquire the mutex, so won't=
 the calling process enter a busy loop if it fails?

Regards,
Paul
