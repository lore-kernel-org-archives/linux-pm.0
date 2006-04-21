From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [OT] debugfs and sysfs [Was: Re: RE: on-ness]
Date: Fri, 21 Apr 2006 21:04:48 +0200
Message-ID: <20060421190448.GA15324@isilmar.linta.de>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<200604211130.05650.david-b@pacbell.net>
	<20060421183340.GA3071@isilmar.linta.de>
	<200604211200.45959.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37062942480500105=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604211200.45959.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============37062942480500105==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 21, 2006 at 12:00:45PM -0700, David Brownell wrote:
> > Uh, there's a rule "one-value-per-file" for sysfs. Arrays might be OK in
> > certain cases, but lots of system-specific information in one file? No way,
> > IMHO.
> 
> Remember that sysfs != debugfs, and /sys/kernel/debug is debugfs.

Sorry, missed that bit. Editing my fstab right now :)

>  (And for that matter, binary
> data in sysfs is more than one-value-per-file ... there are plenty of cases
> where that "rule" doesn't need to be obeyed.)

Binary data is special, indeed, but needs to be rare -- and I sincerely
doubt there are "plenty of cases" for sysfs where this rule doesn't need to
be obeyed, but that would be OT now...

Thanks,
	Dominik


--===============37062942480500105==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37062942480500105==--
