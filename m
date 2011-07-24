From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend/resume problems w/ kernel 3.0 and a *docked*
	ThinkPad T400
Date: Mon, 25 Jul 2011 00:34:33 +0200
Message-ID: <201107250034.33633.rjw__28022.4057766192$1311546865$gmane$org@sisk.pl>
References: <201107232127.34255.toralf.foerster@gmx.de>
	<201107242323.54819.rjw@sisk.pl>
	<201107242349.08560.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107242349.08560.toralf.foerster@gmx.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, July 24, 2011, Toralf F=F6rster wrote:
> =

> Rafael J. Wysocki wrote at 23:23:54
> > So the failure happens only if the machine is in the dock?
> =

> No - if the machine was booted (or rebooted) while docked and later was =

> s2ramed (even if the machine was undocked before) - then the kernel crash=
ed =

> (and can only be avoided by unloading the module iwlagn before).

That's strange.  It seems that the wireless adapter depends on something
in the dock on your system.

Please attach dmesg after booting in the dock and outside of it.

Thanks,
Rafael
