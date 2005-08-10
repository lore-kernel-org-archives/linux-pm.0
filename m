From: Dave Jones <davej@redhat.com>
Subject: Re: Re: PowerOP 2/3: Intel Centrino support
Date: Wed, 10 Aug 2005 14:44:45 -0400
Message-ID: <20050810184445.GB14350@redhat.com>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
	<20050810100133.GA1945@elf.ucw.cz>
	<20050810125848.GM852@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77982422975535437=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050810125848.GM852@poupinou.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============77982422975535437==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2005 at 02:58:48PM +0200, Bruno Ducrot wrote:

 > > > Minimal PowerOP support for Intel Enhanced Speedstep "Centrino"
 > > > notebooks.  These systems run at an operating point comprised of a cpu
 > > > frequency and a core voltage.  The voltage could be set from the values
 > > > recommended in the datasheets if left unspecified (-1) in the operating
 > > > point, as cpufreq does.
 > > 
 > > Eh? I thought these are handled okay by cpufreq already?

It does to some extent.  You can't explicitly set a voltage with
cpufreq, but the low-level drivers will match a voltage to a speed
on chips that we know enough info about.

 > ATM I'm wondering what are the pro for those patches wrt current cpufreq
 > infrastructure (especially cpufreq's notion of notifiers).
 > 
 > I still don't find a good one but I'm surely missing something obvious.

I'm glad I'm not the only one who feels he's too dumb to see
the advantages of this. The added complexity to expose something
that in all cases, we actually don't want to expose seems a little
pointless to me.

For example, most of the x86 drivers, if you set a speed, and then
start fiddling with the voltage, you can pretty much guarantee
you'll crash within the next few seconds.  They have to match,
or at the least, be within a very small margin.

Given how long its taken us to get sane userspace parts for cpufreq,
I'm loathe to changing the interfaces yet again unless there's
a clear advantage to doing so, as it'll take at least another 12 months
for userspace to catch up.

		Dave


--===============77982422975535437==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77982422975535437==--
