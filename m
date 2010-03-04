From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: unable to handle kernel paging request on resume
	with 2.6.33-00001-gbaac35c
Date: Thu, 4 Mar 2010 20:14:09 +0100
Message-ID: <201003042014.09444.rjw__46195.1022655287$1267729931$gmane$org@sisk.pl>
References: <20100301175256.GA4034@tiehlicka.suse.cz>
	<201003032204.51167.rjw@sisk.pl>
	<20100304090207.GA4640@tiehlicka.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100304090207.GA4640@tiehlicka.suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Hocko <mstsxfx@gmail.com>
Cc: linux-mm@kvack.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 04 March 2010, Michal Hocko wrote:
> On Wed, Mar 03, 2010 at 10:04:51PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday 03 March 2010, Michal Hocko wrote:
> > > On Tue, Mar 02, 2010 at 09:01:21PM +0100, Rafael J. Wysocki wrote:
> > > > On Tuesday 02 March 2010, Michal Hocko wrote:
> > ...
> > > > So this is just plain 2.6.33 plus one commit.
> > > > 
> > > > Hmm.  There are only a few changes directly related to hibernation in that
> > > > kernel and none of them can possibly introduce a problem like that.
> > > 
> > > My previous kernel was vmlinux-2.6.33-rc8-00164-gaea187c and it didn't
> > > show the problem.
> > 
> > Well, I have no idea which of the commits between -rc8 and .33 final might
> > introduce such a problem.
> > 
> > What graphics is there in the affected box?
> 
> 00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME,
> 943/940GML Express Integrated Graphics Controller (rev 03))

Well, no clue.

The problem appears to be 32-bit specific, though, because I'm unable to
reproduce it on any of my 64-bit boxes.

Rafael
