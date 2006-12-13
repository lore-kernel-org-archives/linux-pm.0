From: Dave Jones <davej@redhat.com>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
	and PowerOP]
Date: Wed, 13 Dec 2006 16:53:51 -0500
Message-ID: <20061213215351.GE2418@redhat.com>
References: <20060914101704.GA17820@elf.ucw.cz> <457FEE17.8080806@gmail.com>
	<20061213210359.GC11843@elf.ucw.cz>
	<200612131332.58606.david-b@pacbell.net>
	<BBB6202A-4F06-4D2D-BD8E-DD34267D85E9@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <BBB6202A-4F06-4D2D-BD8E-DD34267D85E9@comcast.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matthew.a.locke@comcast.net>
Cc: linux-pm@lists.osdl.org, scott.preece@motorola.com, Pavel Machek <pavel@ucw.cz>, Amit Kucheria <amit.kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 13, 2006 at 01:44:02PM -0800, Matthew Locke wrote:

 > > I'd find that it's used on N770, as a good way to kick in low voltage
 > > operation modes.
 > =

 > Except that cpufreq doesn't really support voltage changes

The majority of cpufreq drivers in the tree right now support
voltage scaling just fine.

		Dave

-- =

http://www.codemonkey.org.uk
