From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [RFC] pm_qos: reimplement using plists
Date: Sun, 06 Jun 2010 22:41:10 -0400
Message-ID: <1275878470.7227.557.camel@mulgrave.site>
References: <1275760688.7227.10.camel@mulgrave.site>
	<20100606210553.GB8610@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100606210553.GB8610@gvim.org>
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
Cc: Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2010-06-06 at 14:05 -0700, mark gross wrote:
> what is the scaling charactoristics of plist's for things that have a
> large dynamic range and a significant utilization of it?  (say 16 bits
> of it.  Which is very unlikely to ever happen)

well O(1) as the document says ... actually it's O(n) where n is the
number of different values in the list.  However, it's always better
than the manual search of a single list that pm_qos currently does. 

> I think in practice this will not be an issue as most users only ever
> call the pm_qos API with 2 values (at least kernel users of the API) 

Well, it's better in every case, not just the low range cases.

> I've only had a quick look so far but it looks really good to me.

Thanks.

James
