From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Alternative Concept
Date: Tue, 13 Mar 2007 23:19:53 -0400
Message-ID: <20070314031953.GA21418@isilmar.linta.de>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<CFF99858-3B0C-4492-807E-B61E9CA891E5@nomadgs.com>
	<20070313110851.GB10702@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070313110851.GB10702@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Eugeny Mints <eugeny@nomadgs.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Mar 13, 2007 at 12:08:51PM +0100, Pavel Machek wrote:
> Perhaps first step would be to convert cpufreq to this new framework?

Actually, cpufreq doesn't need to be modified (at least at first). This
new framework can coexist nicely with cpufreq and this framework can export
its capabilities to cpufreq governors (and, possibly, cpuidle governors) if
it so wishes. Only in the mid- to long-term, changes to cpufreq might make
sense. But that's something I cannot predict accurately ;)

Thanks,
	Dominik
