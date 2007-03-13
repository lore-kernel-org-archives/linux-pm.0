From: Pavel Machek <pavel@suse.cz>
Subject: Re: Can we call pxa_pm_enter() to take the system to
	different modes
Date: Tue, 13 Mar 2007 19:49:22 +0100
Message-ID: <20070313184922.GB12227@elf.ucw.cz>
References: <200703131513.CHB12027@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200703131513.CHB12027@tataelxsi.co.in>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Sridhar Rao V <sridharraov@tataelxsi.co.in>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue 2007-03-13 20:44:53, Sridhar Rao V wrote:
> Hi,
> How does an application take the system to sleep.

echo mem > /sys/power/state
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
