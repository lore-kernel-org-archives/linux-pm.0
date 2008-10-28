From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting
	for	frozen	filesystems.
Date: Wed, 29 Oct 2008 00:24:27 +0100
Message-ID: <E1KuxvH-0006Q0-Dy__2370.62783348865$1225236464$gmane$org@pomaz-ex.szeredi.hu>
References: <1224886068.6478.21.camel@nigel-laptop>
	<E1KuQ1J-0002Vw-9Q@pomaz-ex.szeredi.hu>
	<1225106427.26724.5.camel@nigel-laptop>
	<200810271237.40049.rjw@sisk.pl>
	<1225107607.26724.9.camel@nigel-laptop>
	<E1KuRN4-0002gS-Hq@pomaz-ex.szeredi.hu>
	<1225141168.26724.23.camel@nigel-laptop>
	<E1KuZKt-0003jl-2N@pomaz-ex.szeredi.hu>
	<1225145607.26724.54.camel@nigel-laptop>
	<E1Kuv87-00064p-Lk@pomaz-ex.szeredi.hu>
	<1225235054.9661.37.camel@nigel-laptop>
	<E1Kuxk4-0006NT-Ie@pomaz-ex.szeredi.hu>
	<1225235860.9661.42.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1225235860.9661.42.camel@nigel-laptop> (message from Nigel
	Cunningham on Wed, 29 Oct 2008 10:17:40 +1100)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ncunningham@crca.org.au
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Wed, 29 Oct 2008, Nigel Cunningham wrote:
> Remember, though, that we're only freezing fuse at the moment, and
> strictly one filesystem at a time. We can thus happily wait for the
> i_mutex taken by some other process to be released.

Not going to work: you need to wait for all requests to be finished,
but those might depend on some other fuse filesystem which has already
been frozen.

Miklos
