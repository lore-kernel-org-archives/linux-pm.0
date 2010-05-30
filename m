From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] complain when users abuse the pm_qos API
Date: Sun, 30 May 2010 21:50:01 +0200
Message-ID: <201005302150.01452.rjw__20121.1133193739$1275248966$gmane$org@sisk.pl>
References: <20100529045027.GE11600@gvim.org> <201005292208.04309.rjw@sisk.pl>
	<4C019D36.8070405@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C019D36.8070405@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Sunday 30 May 2010, Nigel Cunningham wrote:
> Hi.
> 
> On 30/05/10 06:08, Rafael J. Wysocki wrote:
> > On Saturday 29 May 2010, mark gross wrote:
> >> The following patch is to help clean up API abusers of pm_qos where
> >> they call update_request before registering a request.
> >>
> >> --mgross
> >>
> >> --Signed-off-by: markgross<markgross@thegnar.org>
> >
> > Will there be a big issue if I push this during the next merge window?
> 
> What's the point to the patch? That is: why is calling update_request 
> before registering a request such a big problem that it demands a WARN() 
> and dump stack?

It is an API violation if I understand that correctly.

Rafael
