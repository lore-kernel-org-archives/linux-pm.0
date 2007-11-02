From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] Suspend: Testing facility
Date: Fri, 2 Nov 2007 12:04:10 +0100
Message-ID: <200711021204.11093.rjw__45467.6081579693$1194000530$gmane$org@sisk.pl>
References: <200711012357.27797.rjw@sisk.pl> <200711012358.27919.rjw@sisk.pl>
	<1193999626.25744.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1193999626.25744.5.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 2 November 2007 11:33, Johannes Berg wrote:
> 
> > 5 - test the freezing of processes
> 
> > +/* Suspend test levels */
> > +enum {
> > +	TEST_NONE,
> 
> Without reading the code, I assume that this enum controls those levels.
> I think a comment that it is user-space visible API and should not be
> reordered would be warranted.

Yes, you are right.  I'll add the comment.

Thanks,
Rafael
