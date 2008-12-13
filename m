From: "Nick Kossifidis" <mickflemm@gmail.com>
Subject: Re: [ath5k-devel] Bugs on aspire one A150
Date: Sat, 13 Dec 2008 16:08:36 +0200
Message-ID: <40f31dec0812130608x73266375n7b3367938ad687b8__45398.3818217695$1229177449$gmane$org@mail.gmail.com>
References: <491506DB.1070000@gmail.com>
	<b6c5339f0811100851t1fd9a180pfe24312081885467@mail.gmail.com>
	<4918A8C5.3050607@gmail.com>
	<40f31dec0811101412n1a4faf86sf4b1f37bb41caef9@mail.gmail.com>
	<1229174904.4964.5.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1229174904.4964.5.camel@maxim-laptop>
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
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Bob Copeland <me@bobcopeland.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, ath5k-devel@venema.h4ckr.net
List-Id: linux-pm@vger.kernel.org

2008/12/13 Maxim Levitsky <maximlevitsky@gmail.com>:
>
> Hi,
>
> Indeed gpio #3 controls the led.
> I patched ath5k to use it, and led works now fine.
>
>

Please share your patch with the rest and also post an lspci -vnn for
your card so we can handle this in a generic way




-- 
GPG ID: 0xD21DB2DB
As you read this post global entropy rises. Have Fun ;-)
Nick
