From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Regression] 2.6.31-git: tty change broke resume
 from hibernation on MSI Wind U100
Date: Sun, 27 Sep 2009 12:47:16 +0100
Message-ID: <20090927124716.2fd8a1de__24065.7106660821$1254052037$gmane$org@lxorguk.ukuu.org.uk>
References: <200909260038.22079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909260038.22079.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, list <linux-pm@lists.linux-foundation.org>, pm@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 26 Sep 2009 00:38:21 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi Alan,
> 
> As stated at http://bugzilla.kernel.org/show_bug.cgi?id=14229, your commit
> b50989dc444599c8b21edc23536fc305f4e9b7d5
> (tty: make the kref destructor occur asynchronously) appears to have broken
> resume from hibernation on MSI Wind U100.
> 
> I verified that hibernation works correctly with this commit reverted.
> 
> I'm still not sure what the root cause of the problem is, though.

The root cause is that the patch to fix the console async/sync behaviour
went into Andrews tree, back out of it and vanished.

It's a known bug, with a known confirmed fix. You may want to pick it up
and submit it as there is no tty maintainer currently.
