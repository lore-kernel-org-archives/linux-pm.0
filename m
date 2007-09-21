From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 14:18:19 +0200
Message-ID: <200709211418.20358.rjw__354.954464319412$1190376405$gmane$org@sisk.pl>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211356.30291.rjw@sisk.pl>
	<200709212158.50538.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709212158.50538.nigel@nigel.suspend2.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Friday, 21 September 2007 13:58, Nigel Cunningham wrote:
> Hi.
> 
> On Friday 21 September 2007 21:56:29 Rafael J. Wysocki wrote:
> > [Besides, the current hibernation userland interface is used by default by
> > openSUSE and it's also used by quite some Debian users, so we can't drop
> > it overnight and it can't be implemented in a compatible way on top of the
> > kexec-based solution.]
> 
> Could it be fudged by giving userland a null image and having (say) the first 
> ioctl be one that triggers all the real work (with other ioctls being noops 
> or such like, as appropriate)?

Well, the "suspend" part is probably doable, but I'm afraid of the "resume"
one.

Greetings,
Rafael
