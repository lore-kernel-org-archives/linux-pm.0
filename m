Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37C457E5F;
	Sun, 20 Sep 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925995; cv=none; b=bes352P+yfIXRKsDjlucrtrGIvQtKVkoQqrPZZnKsPcYO+nsLnSxaVg8agpkbmDA0lSS9c48DxtJv47VIjC/7W1ebRS1KAQX1NG52RzlWg1StoKJRWBQzW6NrSLhJo/DccCno8N9G5qrXVqef7houR0/cYtwdIjzraYTwA0EXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925995; c=relaxed/simple;
	bh=+63oPFLh7ARIDtXlvpiquArAFCUJ81U/0+Mmm6Ko5s8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=or+eu+arLA0zyMxT+09Xbaxxv1Ao6hX1GuRNWImXTU2Vv5hoCvQjhvG6ukAfltXjYObT3q9MYZ4pd5gNYLXaoLtoRgeDbjkbxXVCWXLLj1vX0r9l+P+ugPbr4yYs0EyT/C0JT1SnSeCqEbQsh3nYabt2PbFwG9K1kIW2FXQeLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4XMtq/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4XMtq/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7C51F00899;
	Sun, 20 Sep 2026 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789925994;
	bh=VvUMIGTj3vABcOGBSpNvKun22aoGRB12Tg5KwprBVrM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=j4XMtq/amUrOKk1TAKur2e7i1ledNw2r6PoAo2qyrz/QfB92OZSPyFrpFVCohmWT0
	 g5U7AXRjHEy17HLu/4+UpdSlJXZ5SfAAGh6naRhMsM5eDagp5Tsdwvky3V4SrvQ26M
	 RSkO9WAQemlfbcn5z6U497LLK1n/xdpvGYM8F8iD1IKR4AomCqR9NT+/Rc2RCxifUz
	 G2T05YFXrEn0gkf8EAwwsfpwoIaFgvAeHgVctN9BqaxDLpIaOu19tuS7AbSVvJkgUX
	 5jRsldCmIcp6lbGZmzVsld1269VIs6jHr3dWetYI5Whc6w+mju9sH4x2T7JMyssW27
	 Mt8lxH3/CLPIQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU
 support
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Chris Paterson <Chris.Paterson2@renesas.com>, 
 Biju Das <biju.das@bp.renesas.com>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260918150730.122056-5-biju.das.jz@bp.renesas.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
 <20260918150730.122056-5-biju.das.jz@bp.renesas.com>
Date: Sun, 20 Sep 2026 18:39:26 +0100
Message-Id: <178992596603.706584.10389874816454714845.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=955;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=+63oPFLh7ARIDtXlvpiquArAFCUJ81U/0+Mmm6Ko5s8=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsBpoNRPhtnGa4Vq/JGWwHO3eRlaQGN69qxxZ+
 mjc/pxYD+iJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarAaaBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiFbiEACIcjt6IrQvpXAxDSBsf/BguU8rXmHzAMQ5eMTbgqftBI0
 qiIUDlchFnJL9w9tbox5PJxhz4WzhZtwMp3zm6K9ZJUTR7VqUEQG4zi+v7fuRPPfdZV4X+6hVjP
 lfLBsGQphhqY1NFxa6hySX6A0hzhUZZWqUUareOmVh3StpXaqhHiK2CHzw/CCbFwre/wByLCfB8
 y2C3C5F07VbW3Urw1NIs98ZqjtbNri2NON26f2PStMK1BL9La029iTgpLfB9rzhJfDXc/IY1zI3
 6Zp/9pVM7A+WC1dFrYVPnh1/OGubQ+GZgrY2rHrJMfJC5kOmm0vweUOnaAD5y5hOTzjYgG5Zvnv
 LlpKm/Y1vIp5adlYKXp2/cNBbHF6NL6FRuaypeEF+6VIstHccAlkviTqEaoLjx84H5eOHwB0pdR
 ACN7wuDSY+EcDJNrulwGd4j9WccqKXJ53bkGbSdHM081QW7vH6uG/AgfUOPwh7hlCXZbGM6eaIZ
 Phf1wPwPunGjq3NO4vYxgsJlGBOY2RnMOY0oCk7lWLp86juXtqj84ZxIf29XhqUJhDli/00/Fd5
 a8y9R/FYwUjegS1zWJ0HvIptZw6PpQikuIHKmNWLh4nGCLgcsklXU/4sFnfEUqfkRp47sN5NyJd
 LbPcqRLRihe/mT7XMb9EndyY+sO+HFe7gtNZ1Fg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add a conditional schema constraint so that '#io-channel-cells' is
> required when the compatible string is "renesas,r9a08g045-adc".
> 
> This is required because the R9A08G045 ADC serves as an IIO provider,
> allowing external hardware consumer nodes (such as the TSU) to reference
> its individual channels. The '#io-channel-cells' property must be present
> so consumers can correctly specify the channel index in their 'io-channels'
> phandle property.
> 
> Fixes: a3152e5c742c ("dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

I think perhaps the description should include why this only applies
to this part , and not more generally but otherwise this is fine by
me.  The connection would be more obvious if it were
the 046 part that you were specifying this for given that only
has the one channel.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
