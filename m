From: Dave Jones <davej@redhat.com>
Subject: Re: suspending to disk on FC6 not working
Date: Sun, 1 Oct 2006 14:36:07 -0400
Message-ID: <20061001183607.GG28868@redhat.com>
References: <EB12A50964762B4D8111D55B764A8454ABBCA8@scsmsx413.amr.corp.intel.com>
	<20061001052203.GF28868@redhat.com>
	<200610011428.20557.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200610011428.20557.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sun, Oct 01, 2006 at 02:28:19PM +0200, Rafael J. Wysocki wrote:

 > Well, IMHO, making the module load when we know it won't work is a hack
 > in the first place. :-)

That's just it, we *don't* know if it'll work or not until we load it.

	Dave
