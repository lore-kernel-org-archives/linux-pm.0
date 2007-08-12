From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: encrypted hibernation (was Re: Hibernation
	considerations)
Date: Mon, 13 Aug 2007 00:12:26 +0200
Message-ID: <200708130012.27412.rjw__9949.68085219643$1186956249$gmane$org@sisk.pl>
References: <200707151433.34625.rjw@sisk.pl> <20070805195628.GA1947@elf.ucw.cz>
	<20070811234356.GA19183@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070811234356.GA19183@gallifrey>
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
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, Al Boldi <a1426z@gawab.com>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Vojtech Pavlik <vojtech@suse.cz>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, seife@suse.de, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sunday, 12 August 2007 01:43, Dr. David Alan Gilbert wrote:
> * Pavel Machek (pavel@ucw.cz) wrote:
> > Hi!
> > 
> > > > > Two things which I think would be nice to consider are:
> > > > >    1) Encryption - I'd actually prefer if my luks device did not
> > > > >        remember the key accross a hibernation;

Why exactly (assuming that the hibernation image is encrypted)?

Greetings,
Rafael
