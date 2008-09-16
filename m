From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: DSDT from your system / new DSDT archive
Date: Tue, 16 Sep 2008 19:22:31 -0300
Message-ID: <20080916222231.GB26035__44895.218712236$1221603900$gmane$org@khazad-dum.debian.net>
References: <20080916165543.EA6A42003D@smtp.hushmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080916165543.EA6A42003D@smtp.hushmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Scott Thompson <postfail@hushmail.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Sep 2008, Scott Thompson wrote:
> Since a current one doesn't seem to exist, I am attempting to put 
> my own database together up on the 
> internets (URL coming soon) and am looking for folks to send me the 
> DSDT from their systems.  Gathering your system DSDT takes
> less than about 2 minutes by running the following:  

You also want the dmidecode output, which BTW you must sanitize to remove
UUIDs and serial numbers.  Otherwise, the DSDTs are a lot less useful.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
