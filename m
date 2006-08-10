From: Dave Jones <davej@redhat.com>
Subject: Re: OLS 2006 PM-BOF notes
Date: Thu, 10 Aug 2006 17:22:46 -0400
Message-ID: <20060810212246.GC31619@redhat.com>
References: <20060810211818.GA18032@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060810211818.GA18032@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 10, 2006 at 02:18:18PM -0700, Mark Gross wrote:
 =

 > CPUFREQ :
 > Too many governors.  Can we collapse some of the governors that have a l=
ot of
 > code in common?  Should the conservative governor be implemented as a
 > constraint to the on demand driver / implemented by passing tuning param=
eters?

This has been proposed a few times. Just needs someone to do the work.

 > Can we remove the power save and performance governors?

Personally, I have no objection, as I never use them, but you can guarantee
someone will concoct a use-case for them.

		Dave

-- =

http://www.codemonkey.org.uk
