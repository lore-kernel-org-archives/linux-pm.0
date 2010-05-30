From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] complain when users abuse the pm_qos API
Date: Sun, 30 May 2010 22:55:24 +0200
Message-ID: <201005302255.24807.rjw__7676.64160016483$1275252951$gmane$org@sisk.pl>
References: <20100529045027.GE11600@gvim.org> <201005302150.01452.rjw@sisk.pl>
	<20100530201142.GC25545@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100530201142.GC25545@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday 30 May 2010, mark gross wrote:
> On Sun, May 30, 2010 at 09:50:01PM +0200, Rafael J. Wysocki wrote:
> > On Sunday 30 May 2010, Nigel Cunningham wrote:
> > > Hi.
> > > 
> > > On 30/05/10 06:08, Rafael J. Wysocki wrote:
> > > > On Saturday 29 May 2010, mark gross wrote:
> > > >> The following patch is to help clean up API abusers of pm_qos where
> > > >> they call update_request before registering a request.
> > > >>
> > > >> --mgross
> > > >>
> > > >> --Signed-off-by: markgross<markgross@thegnar.org>
> > > >
> > > > Will there be a big issue if I push this during the next merge window?
> > > 
> > > What's the point to the patch? That is: why is calling update_request 
> > > before registering a request such a big problem that it demands a WARN() 
> > > and dump stack?
> > 
> > It is an API violation if I understand that correctly.
> 
> Yeah, it is, but now that I'm thinking clearly perhaps a better fix
> would be to change the prototype of pm_qos_update_request to return
> something so callers can check for success.
> 
> Lets fix the API rather than use this patch.  Please dopt apply it.

OK

Rafael
