From: mark gross <640e9920@gmail.com>
Subject: Re: [patch] complain when users abuse the pm_qos API
Date: Sun, 30 May 2010 13:11:42 -0700
Message-ID: <20100530201142.GC25545__16333.977765362$1275250532$gmane$org@gvim.org>
References: <20100529045027.GE11600@gvim.org> <201005292208.04309.rjw@sisk.pl>
	<4C019D36.8070405@crca.org.au> <201005302150.01452.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005302150.01452.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Sun, May 30, 2010 at 09:50:01PM +0200, Rafael J. Wysocki wrote:
> On Sunday 30 May 2010, Nigel Cunningham wrote:
> > Hi.
> > 
> > On 30/05/10 06:08, Rafael J. Wysocki wrote:
> > > On Saturday 29 May 2010, mark gross wrote:
> > >> The following patch is to help clean up API abusers of pm_qos where
> > >> they call update_request before registering a request.
> > >>
> > >> --mgross
> > >>
> > >> --Signed-off-by: markgross<markgross@thegnar.org>
> > >
> > > Will there be a big issue if I push this during the next merge window?
> > 
> > What's the point to the patch? That is: why is calling update_request 
> > before registering a request such a big problem that it demands a WARN() 
> > and dump stack?
> 
> It is an API violation if I understand that correctly.

Yeah, it is, but now that I'm thinking clearly perhaps a better fix
would be to change the prototype of pm_qos_update_request to return
something so callers can check for success.

Lets fix the API rather than use this patch.  Please dopt apply it.

--mgross
 
