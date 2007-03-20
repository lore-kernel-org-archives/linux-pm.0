From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.21-rc4-mm1
Date: Tue, 20 Mar 2007 08:09:44 -0800
Message-ID: <20070320080944.9cb3c765.akpm@linux-foundation.org>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	<45FFF026.4030502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <45FFF026.4030502@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 20 Mar 2007 15:31:02 +0100 Jiri Slaby <jirislaby@gmail.com> wrote:

> Andrew Morton napsal(a):
> >   http://userweb.kernel.org/~akpm/2.6.21-rc4-mm1/
> =

> I'm getting this while trying to swsusp:
> Stopping tasks ...
> Stopping kernel threads timed out after 20 seconds (1 tasks refusing to f=
reeze):
>  swapper
>  Restarting tasks ... done.
> =

> What to test? Enable PM_DEBUG?

hm, OK.  Rafael has been working on fixing the process freezer and it'll
take some time to get it to where we want it to be, I expect.

Rafael, I think that we could afford to add heaps of debug in there at this
stage to help us track down problems like this.

Also, it might be useful to add a temporary /proc/freeze-unfreeze thing
which will simply do a freeze/unfreeze cycle.  Then we can apply various
workloads to the machine while madly stressing the freezer code.  =
